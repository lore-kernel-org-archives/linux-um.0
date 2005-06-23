Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlPzA-0003Dv-Ls	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 04:35:08 -0700
Received: from mailgate1.dslextreme.com ([66.51.199.94])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlPz8-0002v2-3P	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 04:35:08 -0700
Message-ID: <208a0a2ca0a15620a725a0a.20050623043456.pbqrznpuvar@www.dslextreme.com>
In-Reply-To: <20050620154329.F19306@sphinx.mythic-beasts.com>
References: 
    <7920a17820a19800a14b80a.20050620073424.pbqrznpuvar@www.dslextreme.com>
    <20050620154329.F19306@sphinx.mythic-beasts.com>
Subject: Re: [uml-devel] problem booting uml without xterms
From: codemachine@dslextreme.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 23 Jun 2005 04:34:56 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
To: Paul Warren <pdw@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


Thanks! i put tty0 in /etc/securetty without even testing the con
parameters and that lets me login from where i launched it which is fine
by me.

my bad on the list. thanks again

Paul Warren
> On Mon, Jun 20, 2005 at 07:34:24AM -0700, codemachine@dslextreme.com
> wrote:
>> I'm trying to  boot uml on a server, and I don't want to have to have X
>> installed to do it, so I want to boot without the xterm consoles.
>>
>> For the life if me I can't figure out the right con=3D* command line
>> params
>> and/or get them to work per:
>
> We use:
>
> con=3Dnull con0=3Dfd:0,fd:1
>
> but you'll need to tweak your root image so that:
>
> 1. inittab brings up a getty on tty0
> 2. tty0 is listed in /etc/securetty.
>
> This is probably one for the user list, BTW.
>
> Paul
>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
