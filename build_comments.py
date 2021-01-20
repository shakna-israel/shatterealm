import os
import json

import requests

srauth = os.getenv('srauth')

if not srauth:
	raise RuntimeError('No srauth in ENV')

headers = {'Authorization': 'token {}'.format(srauth)}

payload = {}

r = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets', headers=headers)
data = r.json()
for item in data['results']:
	try:
		payload[item['title']]
	except KeyError:
		payload[item['title']] = []

	r2 = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets/{}/events'.format(item['id']), headers=headers)
	thread_events = r2.json()

	for event in thread_events['results']:
		if event['event_type'] == ['comment']:
			comment = event['comment']

			if comment['text'].strip() != '[deleted]':
				payload[item['title']].append({"user": comment['submitter']['canonical_name'], "content": comment['text']})

	while thread_events['next'] != None:
		r2 = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets/{}/events?start={}'.format(item['id'], thread_events['next']), headers=headers)
		thread_events = r2.json()

		for event in thread_events['results']:
			if event['event_type'] == ['comment']:
				comment = event['comment']

				if comment['text'].strip() != '[deleted]':
					payload[item['title']].append({"user": comment['submitter']['canonical_name'], "content": comment['text']})

# Ensure we get all data...
while data['next'] != None:
	r = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets?start={}'.format(data['next']), headers=headers)
	data = r.json()
	for item in data['results']:
		try:
			payload[item['title']]
		except KeyError:
			payload[item['title']] = []

		r2 = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets/{}/events'.format(item['id']), headers=headers)
		thread_events = r2.json()

		for event in thread_events['results']:
			if event['event_type'] == ['comment']:
				comment = event['comment']

				if comment['text'].strip() != '[deleted]':
					payload[item['title']].append({"user": comment['submitter']['canonical_name'], "content": comment['text']})

		while thread_events['next'] != None:
			r2 = requests.get('https://todo.sr.ht/api/user/~shakna/trackers/shatterealm/tickets/{}/events?start={}'.format(item['id'], thread_events['next']), headers=headers)
			thread_events = r2.json()

			for event in thread_events['results']:
				if event['event_type'] == ['comment']:
					comment = event['comment']

					if comment['text'].strip() != '[deleted]':
						payload[item['title']].append({"user": comment['submitter']['canonical_name'], "content": comment['text']})

with open('_build/comments.json', "w+") as openFile:
	openFile.write(json.dumps(payload))
