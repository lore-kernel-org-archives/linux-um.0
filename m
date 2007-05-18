Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hp1FX-0004Nw-Ft for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 May 2007 05:07:59 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hp1FV-0007Nw-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 May 2007 05:07:59 -0700
Message-ID: <464D9713.3090904@nagafix.co.uk>
Date: Fri, 18 May 2007 13:07:47 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <7EDC24AB1ED682439657D3B7790609D395B358@deepthought.Elpro.local>
In-Reply-To: <7EDC24AB1ED682439657D3B7790609D395B358@deepthought.Elpro.local>
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Sinclair <Andrew.Sinclair@elprotech.com>
Cc: sivakumar.kuppusamy@yahoo.co.in, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Andrew Sinclair wrote:
> Hi there,
> 
> I've been trying to run UML on FC6 (kernel 2.6.20-1.2933.fc6) and appear
> to have encountered the same issue as described in the following
> threads:
You need to upgrade your host kernel.
Try 2.6.21 or >= 2.6.20.8

Antoine


> 
> http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/
> msg04571.html
> 
> http://www.mail-archive.com/user-mode-linux-user@lists.sourceforge.net/m
> sg04479.html
> 
> Has there been any further resolution of trying to get UML to run on
> FC6? The system hangs when I get to "VFS: Mounted root (ext3 filesystem)
> readonly."
> 
> I have applied patches described in both threads to kernel 2.6.19 and
> rebuilt and still encounter issues. I have also tried pre-built kernels
> 2.6.21.1 downloaded via http://uml.nagafix.co.uk/, and 2.6.13.4-bs5,
> 2.6.16.9-bs2, 2.6.18.1-bb2 from
> http://www.user-mode-linux.org/~blaisorblade/binaries/
> 
> I have attempted loads of prebuilt rootfs Busybox 1.5.0, 1.1.0, Debian
> 4.0 from http://uml.nagafix.co.uk/, and also a hostfs rootfs with most
> of the kernels. 
> 
> I am able to get pre-built kernel and rootfs operating on Mepis (using
> kernel 2.6.18.1-bb2 and rootfs busybox-1.5.0) or Red Hat 7.3 (using
> kernel 2.4.32-bs3 and rootfs busybox-1.1.1)
> 
> 
> My command line has been something like
> /linux rootfstype=hostfs init=/bin/sh
> 
> or 
> 
> /linux ubd0=./rootfs init=/bin/sh
> 
> I have also various other switches described in
> http://uml.nagafix.co.uk/ and http://www.landley.net/code/UML.html
> 
> Can anyone help? 
> 
> Kind Regards
> 
> Andrew Sinclair
> 
>> Antoine Martin wrote:
>>>> Downgrading to skas-v8.2 makes things work fine again.
>>> Ah, did you get around to generate a v8.2 patch for 2.6.19?
>> http://www.theshore.net/~caker/uml/patches/skas-2.6.19.1-v8.2.patch
>>
>> So far so good.  I've got a few hosts running it now, but only a few 
>> UMLs on each one.  Still too early to tell if we'll run into the hang 
>> with certain filesystems...
>>
>>>> I think the key to reproducing this is a skas-v9 host.  It doesn't 
>>>> happen for me on every file system, which is somewhat interesting.
>>> Yep, it seems like a nptl/glibc issue (just a guess though)
>> BTW, stay away from 2.6.19.1 if you use ebtables -- there's a BUG. 
>> 2.6.19 works, and the above patch will apply just fine.
>>
>> -Chris
> 
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGTZcTGK2zHPGK1rsRCs8AAJ9YPCCKTlIS+407eF7khjb0GCOJlwCfStBB
R6J3uQ6OiNyuBwhiVLLpFG0=
=xq45
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
