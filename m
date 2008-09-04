Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbAyp-0003qA-58 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 02:18:19 -0700
Received: from mail.unilim.fr ([164.81.1.45] helo=smtp.unilim.fr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KbAym-0003Ab-D0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 02:18:19 -0700
Message-ID: <48BFA7C1.7070105@unilim.fr>
Date: Thu, 04 Sep 2008 11:17:53 +0200
From: Julien Iguchi-Cartigny <julien.cartigny@unilim.fr>
MIME-Version: 1.0
References: <48BC0DE7.1000703@unilim.fr>
	<20080903175933.GB9917@c2.user-mode-linux.org>
In-Reply-To: <20080903175933.GB9917@c2.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="------------020103080002050304020104"
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020103080002050304020104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Jeff,

Both solutions don't satisfy my needs.

- My UML machines run only in terminal mode (no X)
- I don't want to use mechanisms which require root rights.

I've investigated the code of uml_switch and I think a slight
modification can offer a user-level sniff for UML: add a new request
type (uml_switch.c) and create a simple program which connect to the
uml_switch and just dump (in raw or libpcap format) in standard input
the traffic.

I don't think it requires a lot of works...

Julien.

Jeff Dike wrote:
> On Mon, Sep 01, 2008 at 05:44:39PM +0200, Julien Iguchi-Cartigny wrote:
>> I'm using Netkit (www.netkit.org): it's a network simulator using UML
>> and I want to show packets exchanged between the UML machines. I believe
>> the best way is to
>>
>> - use wireshark with the flag "-" to capture packets in the standard input.
>> - use netcat to read the data socket of uml_switch and print to the
>> standard output
>>
>> But uml_switch uses a ctl socket to open new port. I need a way to
>> manually open a port by uml_switch to connect netcat. I don't think
>> uml_switch offer command-line instruction for this, so is the best way
>> to write a short program writing on the ctl socket of uml_switch ? If
>> yes, what data to send to uml_switch ?
> 
> If you want to capture UML network traffic going over uml_switch (be
> it with wireshark or tcpdump - it doesn't matter), there are two basic
> ways of doing it:
> 	enable hub mode (uml_switch -hub) and then either
> 
> 	sniff from a UML's eth0 (a third UML if you don't want to
> interfere with the communicating UMLs), or
> 	add a host tap device to the switch (uml_switch -tap tap<n>)
> and sniff that.
> 
> 				Jeff
> 


-- 
Trouble-a-cat Limited

--------------020103080002050304020104
Content-Type: text/x-vcard; charset=utf-8;
 name="julien_cartigny.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="julien_cartigny.vcf"

begin:vcard
fn:Julien Iguchi-Cartigny
n:Iguchi-Cartigny;Julien
org;quoted-printable;quoted-printable:Universit=C3=A9 de Limoges;D=C3=A9partement DMI
adr;quoted-printable:83, rue d'Isle;;Site Jid=C3=A9;Limoges;;87000;France
email;internet:julien.cartigny@unilim.fr
title:Assistant Professor
tel;work:+33555436930
tel;cell:+33681606483
x-mozilla-html:FALSE
url:http://msi.unilim.fr/~cartigny/
version:2.1
end:vcard


--------------020103080002050304020104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------020103080002050304020104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------020103080002050304020104--

