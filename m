Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL85m-0003cy-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 13:36:30 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AL85l-0008Ng-St
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 13:36:29 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031115213627.GL9377@dijkstra.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [dan@spaz.org: Re: Bug#220679: user-mode-linux: Fails to Mount Root Filesystem on Reboot]
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
Date: Sat, 15 Nov 2003 16:36:27 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 220679-forwarded@bugs.debian.org

I looked briefly at the source and didn't see any immediate reason why this
should work differently after a reboot.  Is there a bug here?

----- Forwarded message from Daniel Burton <dan@spaz.org> -----

Date: Sat, 15 Nov 2003 02:48:20 -0800
From: Daniel Burton <dan@spaz.org>
To: Matt Zimmerman <mdz@debian.org>
Cc: 220679@bugs.debian.org
Subject: Re: Bug#220679: user-mode-linux: Fails to Mount Root Filesystem on
 Reboot

Matt Zimmerman wrote:

>On Thu, Nov 13, 2003 at 07:22:50PM -0800, Daniel Burton wrote:
>
> 
>
>>Package: user-mode-linux
>>Version: 2.4.22-5um-1
>>Severity: normal
>>
>>
>>User Mode Linux will not reboot properly -- it fails to mount the root 
>>filesystem and exits.  Here are my messages:
>>[...]
>>Kernel command line: eth0=daemon,,,/var/run/uml-utilities/uml_switch.ctl 
>>con=pts con0=fd:0,fd:1 ssl0=tty:/dev/ttyS4 mem=512M root=/dev/ubd0
>>   
>>
>
>I assume your root filesystem is named "root_fs" since you are not
>specifying a ubd0= parameter.  Try explicitly assigning a file to the ubd0
>device, i.e.: "ubd0=root_fs" and see if it works in that case.
> 
>
Yes, that seems to fix the problem.

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
