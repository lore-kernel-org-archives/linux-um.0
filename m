Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATXKN-0003j8-90
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 18:10:19 -0800
Received: from scanmail3.cableone.net ([24.116.0.123])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATXKM-0001M6-Fw
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 18:10:18 -0800
Subject: Re: [uml-devel] mounting COW on HOST?
From: greg <greg@lonnon.org>
Reply-To: greg@lonnon.org
In-Reply-To: <009701c3bded$d0efef70$2000000a@schlepptopp>
References: <009701c3bded$d0efef70$2000000a@schlepptopp>
Content-Type: text/plain
Message-Id: <1070935808.4256.25.camel@profx.lonnon.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Mon, 08 Dec 2003 19:10:08 -0700
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Roland,

It wouldn't be that tough to write a COW block device for the standard
kernel.  In fact, if we did that, we could get rid of the COW hack in
the ubd device.  

The basic idea of COW is a bitmap to represent all the sectors of the
block device, a backing block device and a cow block device.  Any
blocking device should work.  

I have also thought of changing the index to be a 4 byte offset, this
would useful for live CD distros with a floppy device.  The floppy
device becomes the COW disk while the backing file is the CDROM.  I
haven't done the math on the usability of 1.4MB floppy or the recovery
mechanism in case of a kernel panic, etc...  But having a live CD in
which any sector could be changed might be interesting, at least make it
easier for the live CD people.

See ya,
Greg

On Mon, 2003-12-08 at 17:45, roland wrote:
> hi!
> one thing came to my mind today: why not porting the COW feature of UML to 
> the "mainstream" linuxkernel itself?
> i would find this useful - not only in relation to UML.
> maybe there is already something like this? don`t know....
> what would we need? modifying loopdevice(mount -o loop...) code? perhaps using 
> lufs for that? (btw: long awaited read/write support for ntfs partitions has 
> been implemented via lufs and native windows ntfs.sys driver!) 
> maybe this has been discussed already?
> 
> regards
> roland
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
