Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXXTL-00089M-CN
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 19:08:07 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXXTL-0006PK-4E
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 19:08:07 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta10.adelphia.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with SMTP
          id <20031220030800.TMRQ12043.mta10.adelphia.net@mizar.alcor.net>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Fri, 19 Dec 2003 22:08:00 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] uml-patch-2.4.22-7
Message-ID: <20031220030759.GY18100@alcor.net>
References: <Pine.LNX.4.44.0312161250240.3476-100000@sparrow> <1071602165.3374.23.camel@wopr.tektonic.net> <200312162255.hBGMtYkS003408@ccure.user-mode-linux.org> <1071617555.5553.4.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071617555.5553.4.camel@wopr.tektonic.net>
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
Date: Fri, 19 Dec 2003 19:07:59 -0800
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Dec 16, 2003 at 06:32:37PM -0500, Matt Ayres wrote:

> Yes, this was it.  The halt symlink was in runlevel 0 but not in 6.  I
> guess I need to find a type to run "cd /etc/rc6.d && ln -sf
> ../init.d/halt S01reboot" inside each UML.  Thanks.

Where did this broken filesystem come from?

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
