Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATXRu-0003zy-Ab
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 18:18:06 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATXRt-0002gb-VG
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 18:18:06 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id E2429389
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon,  8 Dec 2003 21:18:03 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1ATXRr-0003SN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Dec 2003 21:18:03 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] mounting COW on HOST?
Message-ID: <20031209021803.GO582@dijkstra.csh.rit.edu>
References: <009701c3bded$d0efef70$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009701c3bded$d0efef70$2000000a@schlepptopp>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 21:18:03 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 09, 2003 at 01:45:59AM +0100, roland wrote:

> one thing came to my mind today: why not porting the COW feature of UML to 
> the "mainstream" linuxkernel itself?
> i would find this useful - not only in relation to UML.
> maybe there is already something like this? don`t know....
> what would we need? modifying loopdevice(mount -o loop...) code? perhaps using 
> lufs for that? (btw: long awaited read/write support for ntfs partitions has 
> been implemented via lufs and native windows ntfs.sys driver!) 
> maybe this has been discussed already?

This has come up several times before; search the mailing list archives.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
