Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgT2w-0005Mx-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 10:13:46 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AgT2v-0000Dx-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 10:13:45 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401111646.16322.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0401120702070.4503@silk.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0401120702070.4503@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401131914.27510.blaisorblade_spam@yahoo.it>
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
Date: Tue, 13 Jan 2004 19:14:27 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 00:04, luned=EC 12 gennaio 2004, Jeff Chua ha scritto:
> On Sun, 11 Jan 2004, BlaisorBlade wrote:
> > Also, Jeff, when you compiled LVM, did you compile it as module(as you
> > speak about initrd) or statically?
>
> LVM dm-mod (device mapper) is module.
>
> If I don't load this and not start vgscan, mount lvm devices, I don't see
> klog segmentation fault.
Probably building into the kernel that module would work-around your proble=
m.=20
LVM is loaded at startup before klog, I guess, right?

In fact the bug is likely to be with handling of modules, as they go in a=20
different kernel memory area; *maybe* they are in vmalloc'ed memory.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
