Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DHKIU-0003w0-Px for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 03:26:42 -0800
Received: from gridportal.fzk.de ([141.52.160.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DHKIT-0004Sc-By for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 03:26:42 -0800
From: Marcus Hardt <marcus.hardt@iwr.fzk.de>
Subject: Re: [uml-devel] 2.6.10 compilation error
References: <200503311556.54795.marcus.hardt@iwr.fzk.de>
	<200503312240.03995.rob@landley.net>
In-Reply-To: <200503312240.03995.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504011326.37809.marcus.hardt@iwr.fzk.de>
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
Date: Fri, 1 Apr 2005 13:26:37 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Quoting Rob Landley
> On Thursday 31 March 2005 08:56 am, Marcus Hardt wrote:
> > Hi Guys!
> >
> > Whenever I try to compile a 2.6 guest kernel, I get a compilation error:
>
> 2.6.11 (stock from kernel.org) was the first version to work for me out of
> the box.  You might want to try that.

Thank you; this did the job. Enabling the ubd0 block device gave me a bootable 
image, finally :-)

-- 
Marcus


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
