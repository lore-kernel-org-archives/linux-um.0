Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIZr-0004fe-Qk
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:13:51 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201] helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIZr-00058y-Au
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:13:51 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] skas3 + 2.4.21 oops
Message-ID: <20031219111345.GA22779@axis.demon.co.uk>
References: <20031216163134.GA30608@axis.demon.co.uk> <200312180115.hBI1F5kS007913@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312180115.hBI1F5kS007913@ccure.user-mode-linux.org>
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
Date: Fri, 19 Dec 2003 11:13:45 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 17, 2003 at 08:15:05PM -0500, Jeff Dike wrote:
> ncw1@axis.demon.co.uk said:
> > We are running the skas3 patch (host-skas3.patch from the uml website)
> > on top of a debian 2.4.21 kernel tree with fairsched.  We got these
> > oopses recently.  After the second the server was basically unusable -
> > any attempt to use tools like ps to access the process table just
> > never returned.
> 
> This might be incidental - one of the oopsing things might have grabbed the
> task_list semaphore before crapping out.

OK

> > Both of the oopses have write_proc_mm() in the backtrace... 
> 
> That's somewhat incriminating, but strange because no one has reported any
> trouble with skas3 for over a year.

And we've had no trouble with it either except for this one machine.

> I'm thinking maybe a bad patch interaction.  Did all the patches
> apply cleanly?

I had to check, but yes all the patches looked OK.

What is strange is that we have a lot of machines all running this
kernel, but we only have one machine exhibiting this problem.  We've
swapped all the hardware (bar the hard disks) of the problem host but
the problem has remained.

I think it is activity caused by a specific UML which triggers the
problem, but I haven't put my finger on exactly what as it doesn't
happen very often.  I have a pretty good idea which UML triggers the
problem too so we could try moving it to a different host to see if
the problem goes with it.

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
