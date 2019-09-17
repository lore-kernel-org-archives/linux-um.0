Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA9Y0-0004L8-ST
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 09:13:22 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iA9Xw-0007y7-RE
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 11:13:16 +0200
Message-ID: <a4330611422d7caf5e67b9e9967b40e743ea8292.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: time-travel: rewrite as an event scheduler
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 11:13:15 +0200
In-Reply-To: <1568671794-I5687e9cdda059457fa2771ee06f9b4f399dc6f70@changeid>
References: <1568671794-I5687e9cdda059457fa2771ee06f9b4f399dc6f70@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org


> +static void time_travel_update_time(unsigned long long next, bool retearly)
> +{
> +	struct time_travel_event *e;
> +
> +	do {
> +		e = list_first_entry_or_null(&time_travel_events,
> +					     struct time_travel_event,
> +					     list);

I've copy/pasted this too much - I'll add a helper for it.

> +		if (e && e->time <= next) {
> +			BUG_ON(!time_travel_del_event(e));
> +			time_travel_set_time(e->time);
> +			time_travel_deliver_event(e);
> +		} else {
> +			time_travel_set_time(next);
> +		}
> +	} while (!retearly && time_travel_time < next);
> +}

This has some issues, at least in the time-travel=ext version, where a
new event might be inserted while we're moving time forward.

I think I'll insert that fix here as it's easier to understand in this
context, it basically is to add an event for the "next" time, and then
wait until that event's turn.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

