#!/usr/bin/env python3
import os
import smtplib
import requests
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime
import psycopg2
import json


SMTP_HOST = os.getenv('SMTP_HOST', 'smtp.gmail.com')
SMTP_PORT = int(os.getenv('SMTP_PORT', 587))
SMTP_USER = os.getenv('SMTP_USER', '')
SMTP_PASSWORD = os.getenv('SMTP_PASSWORD', '')
ALERT_EMAIL = os.getenv('ALERT_EMAIL', 'team@crypto-project.com')
SLACK_WEBHOOK = os.getenv('SLACK_WEBHOOK', '')

def check_anomalies():
    """Check for price anomalies"""
    conn = psycopg2.connect(
        host='localhost',
        database='crypto_db',
        user='crypto_user',
        password='crypto_pass123'
    )
    cur = conn.cursor()
    
   
    cur.execute("""
        SELECT name, current_price, price_change_percentage_24h
        FROM crypto_dbt.mart_crypto_metrics
        WHERE ABS(price_change_percentage_24h) > 20
        ORDER BY ABS(price_change_percentage_24h) DESC
        LIMIT 10;
    """)
    anomalies = cur.fetchall()
    
    cur.close()
    conn.close()
    return anomalies

def send_email_alert(anomalies):
    """Send email alert"""
    if not SMTP_USER or not SMTP_PASSWORD:
        print("Email credentials not configured")
        return
    
    msg = MIMEMultipart()
    msg['From'] = SMTP_USER
    msg['To'] = ALERT_EMAIL
    msg['Subject'] = f'Crypto Market Alert - {datetime.now().strftime("%Y-%m-%d %H:%M")}'
    
    body = f"""
    <h2>🚨 Crypto Market Alert</h2>
    <p>Detected {len(anomalies)} coins with abnormal price movements (>20%):</p>
    <table border="1">
        <tr><th>Coin</th><th>Price (USD)</th><th>24h Change</th></tr>
    """
    
    for coin in anomalies:
        body += f"<tr><td>{coin[0]}</td><td>${coin[1]:,.2f}</td><td>{coin[2]:+.2f}%</td></tr>"
    
    body += "</table><p>Please check the dashboard for more details.</p>"
    
    msg.attach(MIMEText(body, 'html'))
    
    try:
        server = smtplib.SMTP(SMTP_HOST, SMTP_PORT)
        server.starttls()
        server.login(SMTP_USER, SMTP_PASSWORD)
        server.send_message(msg)
        server.quit()
        print("Email alert sent successfully")
    except Exception as e:
        print(f"Failed to send email: {e}")

def send_slack_alert(anomalies):
    """Send Slack webhook alert"""
    if not SLACK_WEBHOOK:
        print("Slack webhook not configured")
        return
    
    if not anomalies:
        return
    
    text = f"🚨 *Crypto Market Alert*\nDetected {len(anomalies)} coins with abnormal price movements:\n"
    for coin in anomalies:
        text += f"\n• {coin[0]}: {coin[2]:+.2f}% (${coin[1]:,.2f})"
    
    payload = {'text': text}
    
    try:
        response = requests.post(SLACK_WEBHOOK, json=payload)
        if response.status_code == 200:
            print("Slack alert sent successfully")
        else:
            print(f"Failed to send Slack alert: {response.status_code}")
    except Exception as e:
        print(f"Failed to send Slack alert: {e}")

if __name__ == "__main__":
    anomalies = check_anomalies()
    
    if anomalies:
        print(f"Found {len(anomalies)} anomalies")
        send_email_alert(anomalies)
        send_slack_alert(anomalies)
    else:
        print("No anomalies detected")
