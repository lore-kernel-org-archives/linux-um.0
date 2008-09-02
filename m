Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaSxp-000287-Lq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 03:18:21 -0700
Received: from tallyho.bytemark.co.uk ([80.68.81.166])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaSxl-0000xG-Th
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 03:18:21 -0700
Date: Tue, 2 Sep 2008 12:18:09 +0200
From: Luca Bigliardi <shammash@artha.org>
Message-ID: <20080902101808.GR3824@pintsize>
References: <48BC0DE7.1000703@unilim.fr> <1220291098.2995.3.camel@clownix>
	<48BCFBAE.3050402@unilim.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48BCFBAE.3050402@unilim.fr>
Subject: Re: [uml-devel] Connecting UML_SWITCH and Wireshark
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Julien Iguchi-Cartigny <julien.cartigny@unilim.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 02, 2008 at 10:39 AM, Julien Iguchi-Cartigny wrote:

Hi Julien,

> >> - use wireshark with the flag "-" to capture packets in the standard input.
> >> - use netcat to read the data socket of uml_switch and print to the
> >> standard output

On wireshark(1) they say this works only if you have a libpcap format on
wireshark's STDIN, but in this way you'll have pure ethernet frames.

Does Netkit support uml's vde network?
If it does then you can use the 'pdump' plugin in vde_switch which dumps
all the traffic in pcap format.

Here you can find an example of pdump usage:
http://qemu-forum.ipi.fi/viewtopic.php?f=2&p=13488#p13488


HTH

luca

-- 
Beware of programmers who carry screwdrivers.
                        -- Leonard Brandwein

http://shammash.homelinux.org/ - http://www.artha.org/ - http://www.yue.it/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
