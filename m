Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaRQB-0000WT-JU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 01:39:31 -0700
Received: from mail.unilim.fr ([164.81.1.45] helo=smtp.unilim.fr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaRQ9-0007xC-FC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 01:39:31 -0700
Message-ID: <48BCFBAE.3050402@unilim.fr>
Date: Tue, 02 Sep 2008 10:39:10 +0200
From: Julien Iguchi-Cartigny <julien.cartigny@unilim.fr>
MIME-Version: 1.0
References: <48BC0DE7.1000703@unilim.fr> <1220291098.2995.3.camel@clownix>
In-Reply-To: <1220291098.2995.3.camel@clownix>
Content-Type: multipart/mixed; boundary="------------060209030408000906070701"
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
To: vincent-perrier <vincent-perrier@club-internet.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060209030408000906070701
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Vincent,

Netkit doesn't support X, and I don't want it anyway, as the user has
already several terminals on his screen (one by UML machine).

I want Wireshark to be running on the host computer, and I don't want to
use the TAP solution (students using the simulator don't have root access).

So, the only way is to connect wireshark on uml_switch (how ?).

Cheers,

Julien.

vincent-perrier wrote:
> Hello
> I made another network simulator (clownix.net) and I just run
> wireshark inside the uml machines, I do not see why you have 
> troubles to see ip frames.
> 
> 
> 
> 
> Le lundi 01 septembre 2008 à 17:44 +0200, Julien Iguchi-Cartigny a
> écrit :
>> Hello,
>>
>> (seems a developper question, apologies if it's more a user (moron)
>> question)
>>
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
>>
>> Cheers,
>>
>> Julien.
>>
>>
>> -------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
>> Build the coolest Linux based applications with Moblin SDK & win great prizes
>> Grand prize is a trip for two to an Open Source event anywhere in the world
>> http://moblin-contest.org/redirect.php?banner_id=100&url=/
>> _______________________________________________ User-mode-linux-devel mailing list User-mode-linux-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-- 
Trouble-a-cat Limited

--------------060209030408000906070701
Content-Type: text/x-vcard; charset=utf-8;
 name="julien_cartigny.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="julien_cartigny.vcf"

YmVnaW46dmNhcmQNCmZuOkp1bGllbiBJZ3VjaGktQ2FydGlnbnkNCm46SWd1Y2hpLUNhcnRp
Z255O0p1bGllbg0Kb3JnO3F1b3RlZC1wcmludGFibGU7cXVvdGVkLXByaW50YWJsZTpVbml2
ZXJzaXQ9QzM9QTkgZGUgTGltb2dlcztEPUMzPUE5cGFydGVtZW50IERNSQ0KYWRyO3F1b3Rl
ZC1wcmludGFibGU6ODMsIHJ1ZSBkJ0lzbGU7O1NpdGUgSmlkPUMzPUE5O0xpbW9nZXM7Ozg3
MDAwO0ZyYW5jZQ0KZW1haWw7aW50ZXJuZXQ6anVsaWVuLmNhcnRpZ255QHVuaWxpbS5mcg0K
dGl0bGU6QXNzaXN0YW50IFByb2Zlc3Nvcg0KdGVsO3dvcms6KzMzNTU1NDM2OTMwDQp0ZWw7
Y2VsbDorMzM2ODE2MDY0ODMNCngtbW96aWxsYS1odG1sOkZBTFNFDQp1cmw6aHR0cDovL21z
aS51bmlsaW0uZnIvfmNhcnRpZ255Lw0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------060209030408000906070701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------060209030408000906070701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------060209030408000906070701--

