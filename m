Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwiHR-00075T-IR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 07:52:57 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EwiHN-0002zO-PE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 07:52:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The init_maps bug which cause mem map error
References: <39134b110601100614o14112d19r@mail.gmail.com>
	<200601110040.02121.blaisorblade@yahoo.it>
	<20060111162151.GC10179@ccure.user-mode-linux.org>
In-Reply-To: <20060111162151.GC10179@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601111652.39727.blaisorblade@yahoo.it>
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
Date: Wed, 11 Jan 2006 16:52:38 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, wang lianwei <lianwei.wang@gmail.com>

On Wednesday 11 January 2006 17:21, Jeff Dike wrote:
> On Wed, Jan 11, 2006 at 12:39:59AM +0100, Blaisorblade wrote:
> > On Tuesday 10 January 2006 15:14, wang lianwei wrote:
> > (What happened to these bad "*" guys ;-) ? )

> Yeah, this would have been better expressed as a patch.

> > > total_len = phys_len + iomem_len + highmem_len;

> > Remember people: never compare apples with bananas (or whatever).

> Yup, sometimes I wish we had strongly typed integers...

Yeah :-] ...

I think in Java APIs tend to do almost that... not at that point, but they use 
distinct classes for Point and Dimension and Rectangle and whatsoever... and 
I even have to study these things.

> > Thanks for
> > the note. It's the first patch on my queue.

> OK, I was going to fix it here, but I'll just let you send it in.

Will be in my next queue flush...

> Does this fix the 2M iomem problem?

Ah, well, he's the reporter of that problem, and he also worked diagnosing 
it... compliments!

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
