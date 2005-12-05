Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjMnk-0005M5-PY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Dec 2005 12:19:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EjMnj-0007bf-0I
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Dec 2005 12:19:08 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Fwd: Re: [PATCH 0/4] linux-2.6-block: deactivating
	pagecache for benchmarks
References: <1133443051.6110.32.camel@noti>
	<200512042003.48511.rob@landley.net>
	<20051205192114.GB6819@ccure.user-mode-linux.org>
In-Reply-To: <20051205192114.GB6819@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051418.55328.rob@landley.net>
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
Date: Mon, 5 Dec 2005 14:18:55 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 05 December 2005 13:21, Jeff Dike wrote:
> On Sun, Dec 04, 2005 at 06:03:48PM -0800, Rob Landley wrote:
> > Hey Jeff, you wanted the ability to shrink all the caches and free
> > up memory for the hotpluggy thing?
>
> Close, but what I really want is to free up a specified amount of page
> cache.  So, if I want to remove 16M from a UML, and get_free_pages can
> only give me 10 before returning NULL, then I want to say "drop 6M of
> cache, and make it the oldest 6M".
>
> Conceptually, I want to put memory pressure on the thing until it
> drops enough cache to free the memory I want.

Reply to the original on linux-kernel then (or cc: Andrew).  I just thought 
you might be interested.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
