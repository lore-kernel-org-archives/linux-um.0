Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070816110116.GA8100@pingi.kke.suse.de>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
	<20070816084635.GA15985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0708161248050.22579@kivilampi-30.cs.helsinki.fi>
	<20070816110116.GA8100@pingi.kke.suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <28AF5775-A29A-4BB8-83DA-2CAEAEDA164E@mac.com>
From: Daniel Schaffrath <danielschaffrath@mac.com>
Date: Sat, 18 Aug 2007 17:14:00 +0200
Subject: Re: [uml-devel] drivers/infiniband/mlx/mad.c misplaced ;
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Karsten Keil <kkeil@suse.de>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linux-s390@vger.kernel.org, Satyam Sharma <satyam@infradead.org>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com, mikep@linuxtr.net, Netdev <netdev@vger.kernel.org>, netfilter-devel@lists.netfilter.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com


On 2007/08/16  , at 13:01, Karsten Keil wrote:

> On Thu, Aug 16, 2007 at 01:22:04PM +0300, Ilpo J=E4rvinen wrote:
>>
>> ...I guess those guys hunting for broken busyloops in the other  =

>> thread
>> could also benefit from similar searching commands introduced in this
>> thread... ...Ccing Satyam to caught their attention too.
>>
>>
>> ./drivers/isdn/hisax/hfc_pci.c
>> 125:	if (Read_hfc(cs, HFCPCI_INT_S1)) ;
>> 155:	if (Read_hfc(cs, HFCPCI_INT_S1)) ;
>> 1483:					if (Read_hfc(cs, HFCPCI_INT_S1)) ;
>> --
>> ./drivers/isdn/hisax/hfc_sx.c
>> 377:	if (Read_hfc(cs, HFCSX_INT_S1)) ;
>> 407:	if (Read_hfc(cs, HFCSX_INT_S2)) ;
>> 1246:					if (Read_hfc(cs, HFCSX_INT_S1)) ;
>> --
>
> These are workaround to not get compiler warnings about ignored return
> values I got some time ago under some architecture.
Maybe '(void) Read_hfc(cs, HFCSX_INT_S1)' is a better option to get  =

rid of the warnings.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
