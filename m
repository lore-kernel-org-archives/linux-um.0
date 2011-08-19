Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QuKo7-0005nc-HG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Aug 2011 08:52:03 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QuKo6-0005PI-3x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Aug 2011 08:52:03 +0000
Message-ID: <4E4E2427.9080602@nod.at>
Date: Fri, 19 Aug 2011 10:51:51 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <E1Qu7nv-0007OP-3E@ZenIV.linux.org.uk> <4E4D642F.3010909@nod.at>
	<20110818191946.GW2203@ZenIV.linux.org.uk>
	<20110819043120.GY2203@ZenIV.linux.org.uk>
In-Reply-To: <20110819043120.GY2203@ZenIV.linux.org.uk>
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
Subject: Re: [uml-devel] Subject: [PATCH 00/91] pending uml patches
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am 19.08.2011 06:31, schrieb Al Viro:
> On Thu, Aug 18, 2011 at 08:19:46PM +0100, Al Viro wrote:
>> On Thu, Aug 18, 2011 at 09:12:47PM +0200, Richard Weinberger wrote:
>>> Have you touched your patches since yesterday?
>>> I've already pulled and uploaded them to my shiny new git repo at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rw/linux-um.git unstable
>>
>> Reordered and added missing S-o-b on a couple, split one commit.
>
> Umm...  One comment after looking at your tree: you probably want to rebase
> for-3.2 on top of fixes (and presumably feed it to sfr for inclusion into
> linux-next).

Please slow down a bit. :-)
All these branches are just for testing purposes.
That's why I have not announced them nor sent a pull request to Linus.

Anyway, thanks for the hints!

Thanks,
//richard

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

