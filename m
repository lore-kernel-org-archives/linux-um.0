Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bNc5a-00005c-Q5
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 08:33:46 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bNc5V-0002i6-42
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 08:33:46 +0000
References: <20160713030256.GA26654@taihen.jp>
	<CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
	<20160714030836.GA1538@taihen.jp>
From: Richard Weinberger <richard@nod.at>
Message-ID: <57874E5D.9030906@nod.at>
Date: Thu, 14 Jul 2016 10:33:33 +0200
MIME-Version: 1.0
In-Reply-To: <20160714030836.GA1538@taihen.jp>
Subject: Re: [uml-devel] UML tools anywhere?
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Mattia Dongili <malattia@linux.it>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>



Am 14.07.2016 um 05:08 schrieb Mattia Dongili:
> On Wed, Jul 13, 2016 at 11:11:03PM +0200, Richard Weinberger wrote:
>> Hi!
>>
>> On Wed, Jul 13, 2016 at 5:02 AM, Mattia Dongili <malattia@linux.it> wrote:
>>> Hi,
>>>
>>> Does anybody knows if there is any newer version of the tools package
>>> (the one with tunctl, uml_mount and friends)?
>>>
>>> I'm maintaining[1] the package in Debian and I was wondering whether the
>>> original code is hosted somewhere.
>>
>> http://user-mode-linux.sourceforge.net/old/dl-sf.html
>>
>> There is no newer version.
> 
> Ha! interesting. I even have a 20070815 (and others post-2004) version
> that is not on that page. I'm wondering how I got that, maybe just a
> snapshot off of CVS.

Sorry, sent you the wrong link, was late yesterday. ;)
http://user-mode-linux.sourceforge.net/downloads.html

It matches what you have, but still old.

>> Do you have a list of issues in the current utilities?
> 
> There are some in the Debian bug tracking system, some (most?) are related to
> packaging issues though[1].
> 
>> Maybe I should take this as chance to convert them to git and make
>> a new release.
> 
> Well my number one wishlist item would be to change the hand rolled
> makefile to something more maintainable where if I have to pass, say,
> LDFLAGS, it'll get honoured by all tools.

Agreed.

> I can certainly help with that, since I would like to do that work
> anyway in order to refresh the debian package. If you want to stuff the
> code in a git repository I can send patches in.

That would be great!

Step one would be converting the CVS repo to git:
http://user-mode-linux.cvs.sourceforge.net/viewvc/user-mode-linux/tools/

Can you do that?

Thanks,
//richard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

