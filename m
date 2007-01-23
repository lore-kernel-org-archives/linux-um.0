Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9NRg-0008Pr-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 07:20:24 -0800
Received: from gw-e.panasas.com ([65.194.124.178] helo=cassoulet.panasas.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9NRe-0001YX-9F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 07:20:23 -0800
Message-ID: <45B627A7.7070407@panasas.com>
Date: Tue, 23 Jan 2007 17:20:07 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>		<45AE684D.7070802@theshore.net>
	<45AE67C0.5080003@nagafix.co.uk>		<45AE7DFC.9050704@nagafix.co.uk>
	<45B0A4B7.7050702@nagafix.co.uk>		<1169222858.11134.52.camel@athena.fprintf.net>		<45B0EE71.5040908@nagafix.co.uk>	<1169224702.11134.71.camel@athena.fprintf.net>	<45B0F512.6020308@nagafix.co.uk>
	<45B10106.6060107@nagafix.co.uk>
	<45B12269.8040203@nagafix.co.uk> <45B32F92.80409@panasas.com>
	<45B364DC.8040405@nagafix.co.uk>
In-Reply-To: <45B364DC.8040405@nagafix.co.uk>
Content-Type: multipart/mixed; boundary="------------010106090605080109040302"
Subject: Re: [uml-devel] buggy UML AMD64?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010106090605080109040302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Antoine Martin wrote:
>> for me I just do
>> #gdb um/vmlinux (was compiled with -O um)
>> gdb>run ubd0=/var/opt/FedoraCore5-AMD64-root_fs eth0=tuntap,,,192.168.0.117
>> after first trap in gdb
>> gdb>handle SIGUSR1 pass nostop noprint
>> from than on its strait gdb, tell me if you need a script for loading symbols of kernel modules.
>
> That would be great, it could go on the wiki too.
> 
> Thanks
> Antoine

Attach is a script that works for both uml running in gdb or for kgdb.
Usage: add-symbol-file module

Where module can be just the mod_name or mod_name.ko or a full-path

What you do is ssh into a running uml, after the module was loaded by the uml, and run the script.
The printed message is what you need to paste at the gdb command-line. (the first chance you get)
Note that the path echoed is relative to the uml root. You might need to adjust it for gdb since
gdb will see the host path. If the module is inside the root_fs file than you will need to point
gdb to a copy of the module file on the host.

I hope that helps
Boaz Harrosh

--------------010106090605080109040302
Content-Type: text/plain;
 name="add-symbol-file"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-symbol-file"

#!/bin/sh
#
# Print gdb command to load a module's symbols
#
# Copyright (C) 2006 Panasas, Inc.  All rights reserved.
# Copyright (C) 2006 Benny Halevy
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Usage: add-symbol-file module
#   module can be either the module name or path to the module object.
#
# Note: When used in UML, this script must run in UML's context in order
#       to access /sys/module/$mod/sections/.* to get the dynamic relocation
#       addresses but the module path must be valid in gdb's context so that
#       gdb can load the object.
#
progname=`basename $0`
mod=$1
if [ "$mod" = "" ]; then
	echo Usage: `$progname` module 1>&2
	exit 1
fi
if [[ -e "$mod" || "$mod" == */* ]]; then
	obj="$mod"
else
	rel=`uname -r`
	modpath="/lib/modules/$rel/kernel"
	obj=`find $modpath -name "$mod" -o -name "$mod.ko" -o -name "$mod.o" | head -1`
	if [ ! -e "$obj" ]; then
		echo "$progname: $mod was not found in $modpath" 1>&2
		exit 1
	fi
fi
mod=`basename $mod | sed 's/\..*o$//'`
dir=/sys/module/$mod/sections
if [ ! -d $dir ]; then
	echo "$progname: $dir not found" 1>&2
	exit 1
fi

s="`cat $dir/.text`"
for i in .rodata .data .bss; do
	s="$s -s $i `cat $dir/$i`"
done

echo "add-symbol-file $obj $s"

--------------010106090605080109040302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010106090605080109040302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------010106090605080109040302--
