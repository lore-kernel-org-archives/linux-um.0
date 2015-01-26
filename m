Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YFqVz-0001Ra-FT
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 20:44:07 +0000
Received: from mail-vc0-f173.google.com ([209.85.220.173])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YFqVy-0004x4-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 20:44:07 +0000
Received: by mail-vc0-f173.google.com with SMTP id id10so3473940vcb.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Jan 2015 12:44:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F66C82F4-14F8-4354-9B7F-FC764D2A18F9@m3y3r.de>
References: <F66C82F4-14F8-4354-9B7F-FC764D2A18F9@m3y3r.de>
Date: Mon, 26 Jan 2015 21:44:01 +0100
Message-ID: <CAFLxGvxqucFWqFxTVCHwwkHQ0s4HUXeJjMmun3tfs_-dQ3JAZA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] Kmsg dumper patches?
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Daniel Walter <sahne@0x90.at>, UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Jan 18, 2015 at 1:27 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Hi,
>
> Any news. On this?
>
> http://sourceforge.net/p/user-mode-linux/mailman/message/32947218/
> http://sourceforge.net/p/user-mode-linux/mailman/message/32947219/
> http://sourceforge.net/p/user-mode-linux/mailman/message/32947217/

Easy answer, fallen through the cracks. :-\
Thanks for the reminder!

I'm fine with 1/3, please add a more detailed changelog and resend.
For 2/3 I'm not sure why we need this feature, can't you use earlyprintk?
earlyprintk on UML will print everything to stdout.
3/3 is also fine but please coordinate with Daniel and his ftrace work. Daniel?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

