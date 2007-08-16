Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 16 Aug 2007 18:11:17 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0708161248050.22579@kivilampi-30.cs.helsinki.fi>
Message-ID: <alpine.LFD.0.999.0708161801530.25951@enigma.security.iitk.ac.in>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
	<20070816084635.GA15985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0708161248050.22579@kivilampi-30.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="464262402-1168800151-1187268086=:25951"
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?iso-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linux-s390@vger.kernel.org, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com, mikep@linuxtr.net, Netdev <netdev@vger.kernel.org>, netfilter-devel@lists.netfilter.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, Joe Perches <joe@perches.com>, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--464262402-1168800151-1187268086=:25951
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,


On Thu, 16 Aug 2007, Ilpo J=E4rvinen wrote:

>=20
> ...I guess those guys hunting for broken busyloops in the other thread=20
> could also benefit from similar searching commands introduced in this=20
> thread... ...Ccing Satyam to caught their attention too.
>=20
>=20
> > On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> > >=20
> > > There's more than a few of these (not inspected).
> > >=20
> > > $ egrep -r --include=3D*.c "\bif[[:space:]]*\([^\)]*\)[[:space:]]*\;"=
 *=20
>=20
> ...Hmm, I plugged in "a preprocessor" too to manage with non compliant=20
> coding styles :-). Please understand that the line numbers are not an=20
> exact match due to preprocessor changes:
>=20
> $ for i in `find . -name '*.[ch]'`; do echo $i; indent -npro -kr -i8 -ts8=
=20
> -sob -l8000 -ss -ncs -cp1 -nhnl -st $i | egrep -n "[[:space:]]if [(].*[)]=
 ;$";
> done | grep -B1 "^[^.]"

Thanks, looks useful, will check with this.


Satyam
--464262402-1168800151-1187268086=:25951
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--464262402-1168800151-1187268086=:25951
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--464262402-1168800151-1187268086=:25951--

