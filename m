Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A99XD-0000a6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 13:43:19 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A99XA-0007mW-6T
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 13 Oct 2003 13:43:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Patch for buffer overrun in serial/console device logic
References: <3F830C2C.8010308@easyco.com> <3F833EAC.20903@easyco.com> <200310110149.h9B1n94f006954@ccure.karaya.com>
In-Reply-To: <200310110149.h9B1n94f006954@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310132243.58739.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 13 Oct 2003 22:43:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 03:49, sabato 11 ottobre 2003, Jeff Dike ha scritto:
> doug@easyco.com said:
> > The code itself involves a lot of extra parameters from kernel to user
> >  space as things like the current user aren't propogated down.  I
> > personally think that our current patch set is "100% ugly" and would
> > not  consider posting it as-is.  If people are interested in
> > transparent  numeric UID/GID to hostfs, then I would be happy to clean
> > up what we  have and submit it.
>
> OK, that ain't the way to do it.  Anything that involves passing a parallel
> set of creds through VFS will cause Al Viro to lop my head off.  Since I'm
> somewhat attached to it, I will not propose such a thing, no matter how
> cleaned up it is.
>
> What would work is to store the creds in a separate container of some sort
> on the host, and reference that inside hostfs when doing permission checks.
>
> This is more or less what UMSDOS does, from what I understand, and it keeps
> the nastiness contained within hostfs.
>
> That journalling is a neat idea, BTW.
This are my very humble opinions, just my 2 cents, however let's go.
1)a solution involving a setuid UML is just wrong. Something lighter is 
obviously welcome.
2) so, on the host, all files must have the same permissions, and the same 
owner, when you use hostfs as rootfs. I.e., the uid and the gid will have to 
be the same as the ones UML runs with. And the permission will have to be 
fixed ones. For instance, for files we have fumask=644 by default, and it can 
be set to anything not stricter than 600; for dirs, dumask=755 by default, 
and it mustn't be stricter than 700. If and only if you want to have fun, you 
can check if a file has u+x permission and give u+x(or a+x, it's matter of 
taste/security) on the host. These params can be set on the linux command 
line; a mount option can exist, but it must be "bounded" by the boot 
option(the same way you can specify the rootfs option and then restrict even 
more the mount).
Then, there can be UMSDOS-like stuff.
This is the only way to make possible things such as a file that inside UML 
has perms=000 and is readable by root. In this case, hostfs is a true 
filesystem.
3)But, there is a separate issue: accessing the host files, i.e. when you want 
to watch on files existing on the host(so you can't change freely their 
permission). This is a completely different case! Here you can't even suppose 
you can write the UMSDOS like permission-holding file.
So here root has limited permission. My idea here is to make things follow 
some extended semantic, like the 2.6 security models: neither there root has 
all powers, or seeming a NFS mount(neither there root has full permissions). 
It's just a start of idea, but *could* be interesting.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
