Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DpIBw-0001W2-0F	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jul 2005 21:04:20 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DpIBu-0002eK-Oz	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jul 2005 21:04:20 -0700
Received: by wproxy.gmail.com with SMTP id i1so714092wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 03 Jul 2005 21:04:13 -0700 (PDT)
Message-ID: <121565a05070321047c416d00@mail.gmail.com>
From: George P Boutwell <george.boutwell@gmail.com>
Reply-To: George P Boutwell <george.boutwell@gmail.com>
Subject: Re: [uml-devel] [PATCH 1/2] UML - skas0 - separate kernel address
	space on stock hosts
In-Reply-To: <42C88B3F.7040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	 <42C88B3F.7040209@gmail.com>
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
Date: Sun, 3 Jul 2005 23:04:13 -0500
Content-Transfer-Encoding: quoted-printable
To: Victor Condino <un1tz3r0@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 7/3/05, Victor Condino <un1tz3r0@gmail.com> wrote:
> Where can I find the guest patch for the 2.6.12 sources (on top of which
> the skas0 patch will apply)? After looking around for a little while,
> the latest patch I could find anywhere was 2.6.11.8-bs6. I know it's
> probably somewhere obvious and I'm just braindead, but I figured I might
> as well just ask instead of spending any more time combing over webpages =
:)

I've generally had really good success with skas0 from Jeff Dike's
"experimental" patch page...  It's had working and 'stable' skas0
patches for some time now (at least from my limited testing)=20
http://user-mode-linux.sourceforge.net/patches.html

--=20
George


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
