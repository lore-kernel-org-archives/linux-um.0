Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWO0q-0001LF-Hg
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:49:56 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWO0q-0003cn-7X
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:49:56 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta11.adelphia.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with SMTP
          id <20031216224948.TEIQ13090.mta11.adelphia.net@mizar.alcor.net>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Tue, 16 Dec 2003 17:49:48 -0500
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031216224942.GB18100@alcor.net>
References: <20031216222607.GA31999@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216222607.GA31999@alcor.net>
Subject: [uml-devel] Re: [PATCH] hostaudio fails to build as a module
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
Date: Tue, 16 Dec 2003 14:49:42 -0800
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 16, 2003 at 02:26:07PM -0800, Matt Zimmerman wrote:

> DSP_HELP and MIXER_HELP are undefined when MODULE is defined.  This patch
> just moves them out of the conditional.

I hadn't yet received the 2.4.22-7 release announcement when I sent this;
looks like this change is already in there.

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
