Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031209090636.GA12259@bytesex.org>
References: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp> <20031208095906.GB22878@bytesex.org> <004a01c3bdda$dd2e38e0$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a01c3bdda$dd2e38e0$2000000a@schlepptopp>
Subject: [uml-devel] Re: [uml-user] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
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
Date: Tue, 9 Dec 2003 10:06:37 +0100
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Mon, Dec 08, 2003 at 11:30:18PM +0100, roland wrote:
> hi!
> 
> > Known workarounds:
> >   * boot with "hwprobe=-sys" (that will make the hardware detect
> >     skip the critical test), or
> ah - thanks, that seems to work fine. is this just a param, that tells 
> yast to skip the detection test? can you tell me,  why i need to pass 
> that as a kernel param, not as a Yast param or an environment variable? 

It must work for installations too, and there usually the kernel
command line is the only way to pass parameters ...

> in the faq. btw: does YaST2 in gui mode behave the same? don`t have X11-

Probably.  The actual code is in the hardware detection shared library,
(package hwinfo).  "hwinfo --cpu" shows this behavior too.

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
