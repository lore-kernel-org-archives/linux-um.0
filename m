Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXRzb-0000CA-2R
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 13:17:03 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXRza-00013U-Mh
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 13:17:02 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] [UML combo patch] 2.6.0 host-skas kernel & UML kernel patch
Message-ID: <20031219211630.GA31977@elte.hu>
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181304250.3617@earth> <200312191959.27377.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312191959.27377.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Dec 2003 22:16:30 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> > WARNING: this is an experimental patch, UML kernels compiled with this
> > patch wont work in skas mode on older host-skas patched kernels.
> 
> Does this warning refers to any of the other patches you posted? To
> which one especially? Is this related to the removal of
> MM_COPY_SEGMENTS ?

yes, it refers mostly to the removal of MM_COPY_SEGMENTS.

> Also, if there is any incompatibility, it should be named skas4. But
> since Jeff Dike's will release skas4, even improving skas3 by breaking
> compatibility is not useful. And if it is accepted, it should at least
> be released also for 2.4(the guest 2.4/2.6 choice must be unrelated to
> the host choice).

skas4 will be nice, and since it will most likely be 2.6 based (?), it
doesnt have the copy_segments problem.

Jeff, do you know how the new skas4 syscall API will look like, exactly?

	Ingo


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
