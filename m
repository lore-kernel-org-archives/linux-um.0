Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFvDg-0006Ls-7e for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 09:04:44 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GFvDc-0003zt-FW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 09:04:43 -0700
Date: Wed, 23 Aug 2006 12:03:24 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
In-Reply-To: <20060822223432.3f9b3d3e@dch.TQMcube.com>
Message-ID: <Pine.LNX.4.64.0608231034020.3504@sparrow>
References: <20060822223432.3f9b3d3e@dch.TQMcube.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] IPTables Issues on UML Host
Reply-To: William Stearns <wstearns@pobox.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: David Cary Hart <DavidHart@TQMcube.com>
Cc: William Stearns <wstearns@pobox.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Good morning, David,

On Tue, 22 Aug 2006, David Cary Hart wrote:

> I hope that this is the right list.
>
> I have a VDS on UML. Kernel=2.6.17.9
>
> I have re-install netfilter several times and the host just
> recompiled the kernel.
>
> I keep getting the following error:
> # iptables-save >/etc/sysconfig.iptables
> Can't find library for match `tcp'
>
> libipt_tcp.so is where it should be in /lib/iptables. What am I
> missing?

 	I think this is probably independent of UML.

 	If you're building netfilter from scratch, head back to the 
netfilter directory and re-run make; see if there are any errors in the 
build process.  If that works OK, run "make install" to see if it finally 
copies over a libipt_tcp.so.  Depending on the build options, it _may_ be 
installed to /usr/lib/iptables/ instead of /lib/iptables.  If that's the 
case, the easiest way to fix this may be to make a symlnk from the 
existing directory to /lib/iptables.  Up to you.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
         "Smile despite the circumstances and laugh throughout the pain.
Life is full of hardships but it is how you deal with them that will, in
the end, define your character."
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
