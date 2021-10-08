Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYtL9-003gG9-1T
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 17:07:24 +0000
Message-ID: <4e236e5a507bb7bd20059a1e7c09a84610804431.camel@sipsolutions.net>
Subject: Re: Using GDB to debug a user space process in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 08 Oct 2021 19:07:19 +0200
In-Reply-To: <20211008120121.0932b2c9@crass-HP-ZBook-15-G2>
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
 <aeac5d6ec9a59becbe84be6484bb312b216045ad.camel@sipsolutions.net>
 <20211008120121.0932b2c9@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: development@efficientek.com
Cc: YiFei Zhu <zhuyifei1999@gmail.com>, linux-um <linux-um@lists.infradead.org>

On Fri, 2021-10-08 at 12:01 -0500, Glenn Washburn wrote:
> 
> Do you have an idea of what is not working? The only thing I see
> referenced in the cover letter[1] seems to be more of a security issue
> and a functionality issue. So don't run the patch on untrusted code.
> Anything else I should be aware of?

Last I checked, it didn't even compile entirely well, and when I looked
a bit, it seemed the reason it worked for him was that he had some half-
compiled version before/after the changes, likely due to some missing
dependencies in the build system (possibly [2]).

I'm sure it's fixable, and I have an interest in this as well (due to
some payloads I run in UML for my testing), but so far neither of us had
a chance to actually sit down and do it. It's probably not even that
hard.

> According to the cover letter, this could be an answer to the "is
> exec still slow" question I posted earlier. Very cool!

To some extent. It's still slowish I believe - still has to entirely
tear down all the mappings and recreate etc., but not quite as bad any
more because it happens directly in the userspace process, not with a
ton of overhead through executing individual syscalls there. But yeah,
it's much better on fork/exec heavy loads for sure.

johannes

> [1] http://lists.infradead.org/pipermail/linux-um/2021-March/001167.html
[2] https://patchwork.ozlabs.org/project/linux-um/patch/20210928115146.277bec2328bb.If70926505d16d6c6a229002eb6d3f6838b546175@changeid/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

