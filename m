Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v2Ep-0000DS-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 15:05:59 -0700
Received: from adsl-63-201-71-202.dsl.snfc21.pacbell.net ([63.201.71.202] helo=kerbit.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v2Eo-0005QG-LL
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 15:05:58 -0700
Received: from haman (haman [192.168.1.6])
	by kerbit.net (8.11.6/8.9.3) with ESMTP id h84M5q830083
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 4 Sep 2003 15:05:52 -0700
From: Lynn Kerby <lfk@kerbit.net>
Subject: Re: [uml-devel] host-skas3a-RH8.patch
Message-ID: <20030904220551.GC2192@haman.kerbit.net>
References: <200309041536.h84Fa3f8013683@uml.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309041536.h84Fa3f8013683@uml.karaya.com>; from jdike@addtoit.com on Thu, Sep 04, 2003 at 08:36:03 -0700
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
Date: Thu, 4 Sep 2003 15:05:52 -0700
To: user-mode-linux-devel@lists.sourceforge.net


On 2003.09.04 08:36 Jeff Dike wrote:
>There have been a number of requests for skas patches for RH kernels.  Since
>I did skas3 for RH8 a while ago, I have that lying around, and got around
>to releasing it.
>
>It's basically the same as the current skas3 patch, except for a fix which
>allows a !CONFIG_PROC_MM kernel to build, hence the 'a' in the name.
>
>Get it at the usual place.
>
>				Jeff

Thanks Jeff.

Have you looked into making the patch apply to 2.4.20 or later kernels from RH?
It seems that the copy_segments() function is deprecated in the newer kernels
and I'm not quite adventurous enough to try eliminating the copy_segments()/
mm_copy_segments() portions of the skas3 patch.  It looks like the Alan Cox
patches for 2.4.20-22 also include the elimination of copy_segments.

Is everyone that is running current stable kernels on the host just using the
base code?

-- 
Lynn Kerby <mailto:lfk@kerbit.net>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
