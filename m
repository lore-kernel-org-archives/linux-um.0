Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWmVw-0008Aw-1R
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 16:59:40 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWmVu-0005A2-0l
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 16:59:38 -0800
Message-Id: <200312180115.hBI1F5kS007913@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] skas3 + 2.4.21 oops 
In-Reply-To: Your message of "Tue, 16 Dec 2003 16:31:34 GMT."
             <20031216163134.GA30608@axis.demon.co.uk> 
References: <20031216163134.GA30608@axis.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 17 Dec 2003 20:15:05 -0500
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

ncw1@axis.demon.co.uk said:
> We are running the skas3 patch (host-skas3.patch from the uml website)
> on top of a debian 2.4.21 kernel tree with fairsched.  We got these
> oopses recently.  After the second the server was basically unusable -
> any attempt to use tools like ps to access the process table just
> never returned.

This might be incidental - one of the oopsing things might have grabbed the
task_list semaphore before crapping out.

> Both of the oopses have write_proc_mm() in the backtrace... 

That's somewhat incriminating, but strange because no one has reported any
trouble with skas3 for over a year.

I'm thinking maybe a bad patch interaction.  Did all the patches apply cleanly?

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
