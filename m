Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9nZy-0000jY-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:05:38 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9nZx-0008RD-4G
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:05:38 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [uml-user] UML freezes at hdd-intensive processes
References: <36770.128.176.89.137.1109844107.squirrel@128.176.89.137>
	<35767.82.83.49.235.1109878592.squirrel@82.83.49.235>
	<32977.82.83.51.111.1110551392.squirrel@82.83.51.111>
In-Reply-To: <32977.82.83.51.111.1110551392.squirrel@82.83.51.111>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503111102.54214.rob@landley.net>
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
Date: Fri, 11 Mar 2005 11:02:54 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Oliver Baltz <info@OliverBaltz.de>

On Friday 11 March 2005 09:29 am, Oliver Baltz wrote:
> Hi,
>
> my problem still exists: the UML hangs om hdd-intensive processess (like
> apt-get dist-upgrade). I tried a lot of things in time:
>
> o tried on 2 machines with different hardware, different Host- and
> Guest-Kernels
> o CONFIG_BLK_DEV_UBD_SYNC is not set
> o tried ext2/reiserfs on the Guest-UML
> o when the UML hangs, it does not respond to sysrqs
> o SKAS is not patched into the Host-System
> o UML has enough swap-space (tried tmpfs, too)
> o did an strace:
> http://home.oliverbaltz.de/transfer/strace-uml-freeze.txt.gz
>
> I followed this HOWTO: http://oliverbaltz.de/index.php?id=101
>
> Any ideas?
> Thanks in advance.

It sounds like "stick printfs into the source code" time.

It's most likely to be UBD, since A) that's not in standard linux, which 
doesn't have this problem, and B) it's what you exercise intensely when you 
see it.

Is it write-intensive, read-intensive, combination of both, or either one?

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
