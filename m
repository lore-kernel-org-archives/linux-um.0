Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Matt Zimmerman <mdz@debian.org>
Subject: modify_ldt_ldt_s vs. user_desc (Re: [uml-devel] Re: [uml-user] UML (unofficial) patches against vanilla 2.6.2)
Message-ID: <20040213071536.GJ19147@alcor.net>
References: <200402052107.37625.blaisorblade_spam@yahoo.it> <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org>
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
Date: Thu, 12 Feb 2004 23:15:36 -0800
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Fri, Feb 13, 2004 at 12:23:29AM -0500, Jeff Dike wrote:

> As for I-01-Debian_workaround.patch, I had the impression that this was
> caused by a Debian bug.  If so, they should fix it, and I shouldn't have
> to put workarounds in UML for it.

I'm not sure whether this is a bug, but if it is, it is not Debian's bug
alone.  glibc in Debian testing and unstable just happens to provide newer
kernel headers, including asm/ldt.h, which has the new name for the struct
(user_desc vs.  modify_ldt_ldt_s).  There is no provision for backward
compatibility in ldt.h, so apparently user programs are on their own in
determining which name to use.

I was working around this in the debs, but then it was #ifdef'd out
anyway (2.4.22-7? 2.4.23-1?), and I stopped worrying about it.

I don't suppose there would be much harm in adding a macro to ldt.h so that
existing software could continue to work, but that change belongs in the
kernel.

-- 
 - mdz


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
