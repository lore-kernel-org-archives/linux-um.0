Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg42Y-0003wI-8s for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:03:58 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg42Y-00062q-0P for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:03:58 -0700
Message-Id: <s0e3d3a3.027@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Problems compiling 2.4 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
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
Date: Thu, 01 Jul 2004 09:04:24 -0700
Content-Transfer-Encoding: 8bit
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

I'm in the habit of build kernels on machines that are very close to the distribution I run as guest. In the past, I found that this approach (using the default config file that ships with the distribution) can help me choose the right kernel options for the distribution (should I use devfs, which crypto modules should I build, etc).

In this case, the SuSE 9.0 is a i386 2.4 kernel. However, I will try these same steps with a "blank" config.

Tony

>>> Jeff Dike <jdike@addtoit.com> 07/01/04 09:43AM >>>
Anthony_Brock@ous.edu said:
> gzip -dc /proc/config.gz > .config 

wtf are you trying to accomplish here?  You can't use the host's (i386 2.6)
.config to build a 2.4 UML kernel.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
