Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DshLN-0003v9-Pm	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:32:09 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DshLM-0006JQ-8f	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:32:09 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Clarification of UML and AIO?
References: <42D42ED5.4000101@oracle.com>
	<20050712220327.GB4469@ccure.user-mode-linux.org>
In-Reply-To: <20050712220327.GB4469@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131539.25266.blaisorblade@yahoo.it>
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
Date: Wed, 13 Jul 2005 15:39:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Allan Graves <allan.graves@oracle.com>

On Wednesday 13 July 2005 00:03, Jeff Dike wrote:
> > Tracing the aio_read() through the UML kernel finally gets me here:
> >
> > #0  sys_pread64 (fd=3, buf=0xbf7c8f20 "", count=1024, pos=0)
> >   at fs/read_write.c:354
> > #1  0x08062ff8 in execute_syscall_skas (r=0x12374864)
> >   at arch/um/kernel/skas/syscall_kern.c:29

> Finally?  That's the very beginning of the system call (or the very end).

> The UML block device doesn't know about AIO.  All it does is get blocks
> from a disk.

> Are you sure you're getting kernel AIO and not the libc emulation of it?
This is a good answer.... strace will be your friend in verifying this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
