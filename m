Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: modify_ldt_ldt_s vs. user_desc (Re: [uml-devel] Re: [uml-user] UML (unofficial) patches against vanilla 2.6.2)
Message-ID: <20040213135929.GA27460@fieldses.org>
References: <200402052107.37625.blaisorblade_spam@yahoo.it> <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org> <20040213071536.GJ19147@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213071536.GJ19147@alcor.net>
From: "J. Bruce Fields" <bfields@fieldses.org>
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
Date: Fri, 13 Feb 2004 08:59:30 -0500
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Thu, Feb 12, 2004 at 11:15:36PM -0800, Matt Zimmerman wrote:
> 
> I don't suppose there would be much harm in adding a macro to ldt.h so that
> existing software could continue to work, but that change belongs in the
> kernel.

The policy as I understand it has always been that userland needs its
own headers, and that kernel headers are not meant to be usable by
applications unmodified.

Looks like a debian bug to me....

--Bruce Fields


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
