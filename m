Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Alasdair G Kergon <agk@redhat.com>
Message-ID: <20050923211953.GG18976@agk.surrey.redhat.com>
References: <20050920163433.6081be3b.akpm@osdl.org>
	<20050921154846.GW18976@agk.surrey.redhat.com>
	<200509232211.32238.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509232211.32238.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Writing on DM snapshots, and having no "mainstream"
	device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
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
Date: Fri, 23 Sep 2005 22:19:53 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Fri, Sep 23, 2005 at 10:11:31PM +0200, Blaisorblade wrote:
> you can create snapshots *WITHOUT* having a snapshot-origin device 
 
Checking the code, yes you're correct.
When that LVM2 code was developed you'd get an oops but it's been fixed.

Alasdair
-- 
agk@redhat.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
