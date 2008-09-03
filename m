Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kawdo-00078C-Pc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:59:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kawdn-0002Ho-8p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:59:40 -0700
Date: Wed, 3 Sep 2008 13:59:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080903175933.GB9917@c2.user-mode-linux.org>
References: <48BC0DE7.1000703@unilim.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48BC0DE7.1000703@unilim.fr>
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

On Mon, Sep 01, 2008 at 05:44:39PM +0200, Julien Iguchi-Cartigny wrote:
> I'm using Netkit (www.netkit.org): it's a network simulator using UML
> and I want to show packets exchanged between the UML machines. I believe
> the best way is to
> 
> - use wireshark with the flag "-" to capture packets in the standard input.
> - use netcat to read the data socket of uml_switch and print to the
> standard output
> 
> But uml_switch uses a ctl socket to open new port. I need a way to
> manually open a port by uml_switch to connect netcat. I don't think
> uml_switch offer command-line instruction for this, so is the best way
> to write a short program writing on the ctl socket of uml_switch ? If
> yes, what data to send to uml_switch ?

If you want to capture UML network traffic going over uml_switch (be
it with wireshark or tcpdump - it doesn't matter), there are two basic
ways of doing it:
	enable hub mode (uml_switch -hub) and then either

	sniff from a UML's eth0 (a third UML if you don't want to
interfere with the communicating UMLs), or
	add a host tap device to the switch (uml_switch -tap tap<n>)
and sniff that.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
