Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BobZL-00028X-CP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 22:29:07 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BobZK-0006F6-RI for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 22:29:07 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Some firewalls require disabling ECN in the UML kernel
In-Reply-To: <20040725015031.GN783@peak.org>
Message-ID: <Pine.LNX.4.58.0407250120000.6494@sparrow>
References: <20040725015031.GN783@peak.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 25 Jul 2004 01:26:34 -0400 (EDT)
To: Eric House <fixin@peak.org>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good evening, Eric,

On Sat, 24 Jul 2004, Eric House wrote:

> This mail details the solution to a problem I had with UML networking.
> My UML instance was able to ping any host on the LAN or internet, but
> could only make TCP connections within the LAN.  On looking closer I
> found that the initial packets were making it from the host to the
> router and then to my cable modem but not reaching the internet
> server.  I was unable to determine whether the cable modem was
> dropping them (or why), or whether they were making it further.
> 
> Eventually I looked closely at the packets leaving the router, both
> for (successful) telnet connections from non-UML hosts and for the
> (doomed) attempt from the UML instance.  The only difference,
> according to tcpdump running on the router, was that the
> non-UML-sourced packets had only the S flag set while the UML-sourced
> packets had three set: SWE.
> 
> The first hit when googling for "tcpdump SWE" is 
> 
> http://lists.debian.org/debian-user/2001/06/msg01577.html
> 
> a page that explains that some commercial firewalls block packets for
> which TCP ECN is enabled.  And sure enough, the kernel that's part of
> Debian's UML package has it enabled.  Once I turned it off using the
> following command all was well.  I'm currently running apt-get to
> bring the rootfs up to date.
> 
> sysctl -w net.ipv4.tcp_ecn=0
> 
> Of course I still don't know where the packets were getting blocked,
> but my ActionTek DSL modem is the most likely suspect.
> 
> UML rocks!  Thanks!

	(It certainly does!  *smile*)

	Here's the email I send out to sites behind a router or firewall 
that filters ECN.  I customize it for the mail server/web server/other in 
question.
	The ActionTek modem is an _excellent_ place to start the 
investigation.

========
        It appears that the smtp server server_name (ip.address) is
behind a firewall or router that rejects packets with the ECN (Explicit
Congestion Notification) bits set.  As my laptop uses Linux 2.4 - 2.6
kernels, outbound tcp connections have this bit set to indicate that it
can take part in ECN discussions.  Because of this, I have trouble
connecting to your smtp server unless I explicitly turn off ECN.
        I'm _not_ trying to probe you for information about your network
setup, firewalls, or security architecture - promise!  I'm simply letting
you know the problem exists so you can take it up with whoever manages
your network.  Fixing the problem may require updating the firewall
software or router firmware in question.  I'm happy to help in any way,
even down to the level of simply sending a test email message after you've
made an attempt to fix it, to verify that the fix worked.

        Here are a few links to more info on the issue:

        The Linux 2.4 - 2.6 kernels supports ECN - Explicit Congestion
Notification.  Some nat implementations, specifically Cisco pix, Local
Director and Raptor firewalls don't pass ECN enabled packets correctly.

        The RFC for it can be found at:
http://www.cis.ohio-state.edu/rfc/rfc2481.txt
http://www.faqs.org/rfcs/rfc3168.html
        Additional URL's:
http://www.faqs.org/rfcs/rfc2481.html
http://gtf.org/garzik/ecn/

        The above page references a cisco pix advisory:
http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds23698

ftp://ftp.isi.edu/in-notes/rfc2884.txt
http://www.aciri.org/floyd/ecn.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0009.1/0329.html
http://www.securityfocus.com/infocus/1205

        To turn off ECN on Linux 2.4 kernels, I did the following:

echo 0 >/proc/sys/net/ipv4/tcp_ecn

        This last change was what finally allowed the email to get 
through.
========


	Cheers,
	- Bill

---------------------------------------------------------------------------
         "Eagles may soar, high and proud, but weasels don't get sucked
into jet engines."
        --Anon
(Courtesy of Bob Tracy <rct@merkin.csap.af.mil>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
