Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHhb-0005De-Cr
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:29:55 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHhb-0001sd-20
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:29:55 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta9.adelphia.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with SMTP
          id <20031222042949.GRVM5224.mta9.adelphia.net@mizar.alcor.net>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Sun, 21 Dec 2003 23:29:49 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] UML on Alpha
Message-ID: <20031222042948.GZ9354@alcor.net>
References: <20031220052032.GC1152@erdos.home> <200312211644.39563.blaisorblade_spam@yahoo.it> <20031222041523.GA1023@erdos.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222041523.GA1023@erdos.home>
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
Date: Sun, 21 Dec 2003 20:29:48 -0800
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Dec 22, 2003 at 12:15:23PM +0800, Cameron Patrick wrote:

> I've been working on 2.4 so far.  I'm not running 2.6 on any machine at
> all ATM, and from the sounds of this mailing list, you can't run a 2.6
> UML on a 2.4 host?  Also, the Alpha is running Debian woody at the
> moment, and I'm not sure how well that copes with a 2.6 kernel.

It requires that the usual handful of packages be updated (procps,
util-linux, module-init-tools/modutils, etc.).

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
