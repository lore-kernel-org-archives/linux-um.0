Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: nils toedtmann <user-mode-linux-user@nils.toedtmann.net>
Message-ID: <20041104011116.GB5175@gandalf.intern.marcant.net>
References: <20041102150339.GA6904@gandalf.intern.marcant.net>
	<200411030003.38983.blaisorblade_spam@yahoo.it>
	<20041103011704.GD17954@gandalf.intern.marcant.net>
	<200411032037.56892.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032037.56892.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Uml: hostfs sendfile support
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
Date: Thu, 4 Nov 2004 02:11:16 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

I cc this mail to user-mode-linux-devel and LKML, too. But as i do not
subscribe to those lists it will probably get rejected. So you may
want to forward it.


On Wed, Nov 03, 2004 at 08:37:56PM +0100, Blaisorblade wrote:
> On Wednesday 03 November 2004 02:17, nils toedtmann wrote:
> > On Wed, Nov 03, 2004 at 12:03:38AM +0100, Blaisorblade wrote:
> > > On Tuesday 02 November 2004 16:03, nils toedtmann wrote:
> 
> > [...]
> 
> > > >  * hostfs is still broken in 2.6.9, see thread "more hostfs
> > > >    problems w/ current patches (2.4, 2.6)". Last working version is
> > > >    uml-patch-2.4.26-1.
> 
> > > I don't remember at the moment.
> 
> > httpd cannot read files from hostfs (but httpd can list directories,
> > and the httpd user can `cat`, `less`, ... files from hostfs). Strace
> > shows that "sendfile()" fails.
> 
> Ok, this makes sense.
> 
> It's not, probably, a *bug* in the strict sense, but rather a missing feature. 
> I've checked that to support sendfile on 2.6 kernels special help is needed 
> from the FS (i.e., it must implement a special sendfile() function).
> 
> So, if you want to use httpd, either don't use in on hostfs, or use it on 2.4,

That's what i did. It was my sole 2.4-uml ...

> or recompile apache disabling the usage of sendfile(). This is a new notice I 
> get, however.
> 
> That said, there is a possibility the patch is just a one-liner. It seems 
> there is generic support for this. Try the attached one. Report what happens, 
> please, so I know what to do with it. If it works, it will be included in 
> next release.
[...]

Whoopy! It works. Many thanks!

/nils.


-- 
there is no sig.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
