Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B90PJ-00053P-3l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 03:30:49 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B90PI-0007wf-QA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 03:30:48 -0800
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [uml-devel] RFC: lossless printk
Message-ID: <20040401083025.Z28573@almesberger.net>
References: <20040401042512.Y28573@almesberger.net>
	<Pine.LNX.4.58.0404010149580.13832@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404010149580.13832@gradall.private.brainfood.com>;
	from adam@doogie.org on Thu, Apr 01, 2004 at 01:53:58AM -0600
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 1 Apr 2004 08:30:25 -0300
To: Adam Heath <adam@sonycom.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Adam Heath wrote:
> Don't define functions inline like that, place it in a header.

Of course. I just didn't want to touch yet another file for
now. After all, that's just a first try to get feedback.

> The code shouldn't retry forever.  If the output is blocked for a long time,
> the kernel will become stalled.

Hmm, that's a tricky one. What's a good policy in this case ?
Wait up to a fixed amount of time before continuing, and perhaps
do the same thing on the next printk ? Stop retrying after one
timeout ? Make all this configurable ?

> You also don't handle EINTR.

Good point. I actually never saw one happen, even though I have
workloads that almost only printk.

> Are you converting errno to a list of hashes?

Yeah :-) I'll fix this. You hit it usually for EPIPE or the
like.

> And couldn't writing to stderr
> have the same non-blocking problems?

Potentially yes. Not sure if it makes sense to try very hard
to get that last message out, though.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
