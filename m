Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg4Bv-00056R-MT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:13:39 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg4Bv-0002eL-Dg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:13:39 -0700
Message-Id: <s0e3d5e9.041@ORANGE.OUS.EDU>
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
Date: Thu, 01 Jul 2004 09:13:56 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Unfortunately, I have the same problem even if I build a config file from scratch. *sigh* I have to be missing something basic...

Tony


>>> "Anthony Brock" <Anthony_Brock@ous.edu> 07/01/04 09:04AM >>>
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



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
