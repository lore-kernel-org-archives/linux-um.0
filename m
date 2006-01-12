Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwwWO-0007MJ-W6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 23:05:20 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EwwWM-0003yb-5G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 23:05:20 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] The init_maps bug which cause mem map error
Message-ID: <20060112075726.GA21034@ccure.user-mode-linux.org>
References: <39134b110601100614o14112d19r@mail.gmail.com>
	<200601110040.02121.blaisorblade@yahoo.it>
	<20060111162151.GC10179@ccure.user-mode-linux.org>
	<200601111652.39727.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601111652.39727.blaisorblade@yahoo.it>
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
Date: Thu, 12 Jan 2006 02:57:26 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, wang lianwei <lianwei.wang@gmail.com>

On Wed, Jan 11, 2006 at 04:52:38PM +0100, Blaisorblade wrote:
> > Yup, sometimes I wish we had strongly typed integers...
> 
> Yeah :-] ...

But, a nanosecond later, I think about the insanity of bytes_to_page(), 
foo_to_bar(), etc converters that would be needed...

> Ah, well, he's the reporter of that problem, and he also worked diagnosing 
> it... compliments!

Indeed, I just wanted to make sure that fixed it.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
