Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFvcD-0000O1-1O for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 09:30:05 -0700
Received: from mail2.tqmcube.com ([65.98.66.133] helo=mail.tqmcube.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GFvcA-0001V8-Ec
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 09:30:04 -0700
Date: Wed, 23 Aug 2006 12:29:55 -0400
From: David Cary Hart <DavidHart@TQMcube.com>
Message-ID: <20060823122955.04d463b7@dch.TQMcube.com>
In-Reply-To: <Pine.LNX.4.64.0608231034020.3504@sparrow>
References: <20060822223432.3f9b3d3e@dch.TQMcube.com>
	<Pine.LNX.4.64.0608231034020.3504@sparrow>
Mime-Version: 1.0
Subject: Re: [uml-devel] IPTables Issues on UML Host
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
To: William Stearns <wstearns@pobox.com>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 23 Aug 2006 12:03:24 -0400 (EDT), William Stearns
<wstearns@pobox.com> opined:
> Good morning, David,
> 
> >
> > I keep getting the following error:
> > # iptables-save >/etc/sysconfig.iptables
> > Can't find library for match `tcp'
> >> 
>  	I think this is probably independent of UML.
> 
>  	If you're building netfilter from scratch, head back to
> the netfilter directory and re-run make; see if there are any
> errors in the build process.  If that works OK, run "make install"
> to see if it finally copies over a libipt_tcp.so.  Depending on the
> build options, it _may_ be installed to /usr/lib/iptables/ instead
> of /lib/iptables.  If that's the case, the easiest way to fix this
> may be to make a symlnk from the existing directory
> to /lib/iptables.  Up to you. Cheers,
>  	- Bill

Thanks for the reply.
> 
I am a UML nitwit but I even made a static build of IPTables. No
dice. I have also made builds with specified LIBDIR and BINDIR. 

Oh well, I guess that I need to tinker. Fortunately IPTables is
running properly.
-- 
Our DNSRBL - Eliminate Spam at the Source: http://www.TQMcube.com
               Don't Subsidize Criminals: http://boulderpledge.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
