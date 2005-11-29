Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh8J1-0004JL-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:26:11 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eh8Iv-0003jI-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:26:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<877jau7xjc.fsf@amaterasu.srvr.nix>
	<200511271907.45529.rob@landley.net>
In-Reply-To: <200511271907.45529.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511291708.04068.blaisorblade@yahoo.it>
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
Date: Tue, 29 Nov 2005 17:08:03 +0100
To: Rob Landley <rob@landley.net>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Monday 28 November 2005 02:07, Rob Landley wrote:
> On Sunday 27 November 2005 12:31, Nix wrote:

> Did you catch Linus's long rant about how MAP_PRIVATE is deeply stupid and
> that Linux will never really implement it?

What's that?

> And you can fsync and do stuff like journaling within a file.  (Except with
> mmap it's msync.)

> No, just use the madvise(NO_SYNC).

Which doesn't exist.

> Then tmpfs becomes completely 
> irrelevant because any arbitrary file backed mapping can be treated as
> memory.  (Not pinned, but still treated as shared memory.)

> I vaguely remember some discussion about this on linux-kernel, some time
> ago. I wonder how it came out?  (2.6.15-rc2 mman.h doesn't show
> anything...)

What I remember is MADV_TRUNCATE / MADV_FREE / and so on by Badary Pulavarty - 
the equivalent of MADV_DONTNEED with additional truncation of the tmpfs pages 
you have mmaped.

Which is used for UML memory hotunplug patch from Jeff's. IIRC it's in -mm, 
but won't be in 2.6.15 at this point.

> > (security holes? but other users can't *see* that /tmp, which is why it's
> > mode 640, just like their $HOME...)

> Or you could just add the madvise() like I mentioned and forget about tmpfs
> completely.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
