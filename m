Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQDF4-00088y-Uv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 15:39:22 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BQDF4-0004G6-Ar for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 15:39:22 -0700
Message-ID: <09ac01c43d29$f28ac270$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040515201823.24948gmx1@mp013.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml kernel 2.6.6 - processes left after shutdown - Re:
	SuSE 9.1
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
Date: Wed, 19 May 2004 00:46:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net

hi ,
when i shutdown my uml with "init 0"  - after the uml process exits, the console seems to have a problem: the chars i type aren`t
echoed anymore. i need to issue a "reset" on that terminal to have it working right again.

furthermore (and the more important point) - there are processes left running, after uml shutdown:
linux, port-helper and xterm processes are still up and aren`t terminated.
i need to kill them manually, before being able to restart uml.

a similar bug has reported just today.

i`m on suse9.1 - kernel is 2.6.6 (blaisorblade patch).
kernel is compiled on suse9.1

regards
roland



> ----- Original Message ----- 
> From: "roland" <for_spam@gmx.de>
> To: "uml-user" <user-mode-linux-user@lists.sourceforge.net>
> Cc: "Jeff Dike" <jdike@addtoit.com>
> Sent: Saturday, May 15, 2004 9:15 PM
> Subject: SuSE 9.1
> 
> 
> > Hi,
> > UML Kernel 2.6.6 + SuSE9.1 up and running here.
> > :)
> >
> > Test/Setup had been done inside vmware without any third-party installation scripts.
> > - installed suse9.1 inside vmware
> > - installed uml kernel 2.6.6 (+tools) inside that installation
> > - cloned the vmware virtual disk containing the suse 9.1 installation
> > - made that clone available to vmware itself (as sdb1 and sdb2)
> > - mapped sdb1/2 as ubd devices to uml (./linux ubd0=/dev/sdb2...)
> > - did some tuning like adjustments of inittab and fstab, renaming of /lib/tls
> >
> > now it`s up and running here
> >
> > regards
> > roland
 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
