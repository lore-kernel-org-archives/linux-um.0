Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgQ7w-0002vL-Ur	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 09:43:32 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgQ7v-0002la-TY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 09:43:32 -0700
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <1118334683.10190.66.camel@localhost>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
	 <1118334683.10190.66.camel@localhost>
Content-Type: text/plain
Message-Id: <1118336009.10190.74.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 09 Jun 2005 17:53:29 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 2005-06-09 at 17:31 +0100, antoine wrote:
> > > Now, if someone could have a look at hppfs I could resurect my
> > > honeypots.
> > I've not the time, however test the attached patches. The first one fixes the 
> > basical bugs; the second one could be needed to fix a fd leak... but I don't 
> > think it's needed at all, so test with only the first and let me know if the 
> > 2nd is needed, or if there are any problems (in that case, a ready-to-use 
> > hppfs configuration + explaination would be happily accepted, I've really 
> > little time now).
> Works fine with just the first patch. Thank you very much!
Small correction: local file override works fine (files in the host's
fake proc appear in the guest's /proc) but I can't get the honeypot.pl
script to interact with it. 
So for now, I'll have to hardcode all the values I want to hide and hope
that no software is going to rely on them.

I've used the one that was previously working:

#
# Copyright (C) 2002, 2003 Jeff Dike (jdike@karaya.com)
# Licensed under the GPL
#

use hppfs;
use hppfslib;
use strict;

my $dir;

@ARGV and $dir = $ARGV[0];

my $hppfs = hppfs->new($dir);

my $remove_filesystems = remove_lines("hppfs", "hostfs");
my $remove_mtd_nbd_ubd = remove_lines("mtd", "nbd", "ubd");

# Need to be able to add directories, i.e. driver, bus/pci
# partitions needs work
# slabinfo if UML ever uses the slab cache for anything

$hppfs->add("dma" => proc("dma"),
            "devices" => remove_lines("ubd"),
            "exitcode" => "remove",
            "diskstats" => "remove",
            "devices" => $remove_mtd_nbd_ubd,
            "filesystems" => $remove_filesystems,
            "interrupts" => "remove",
            "iomem" => proc("iomem"),
            "mm" => "remove",
            "ioports" => proc("ioports"),
            "kcore" => "remove",
            "mounts" => $remove_filesystems,
            "misc" => "remove",
            "pid/mounts" => $remove_filesystems,
            "partitions" => "remove",
            "stat" => proc("stat"),
            "uptime" => proc("uptime"),
            dup_proc_dir("bus", $dir) );

$hppfs->handler();




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
