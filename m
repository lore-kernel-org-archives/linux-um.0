Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRoyg-007MRg-8x
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 05:35:15 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id jq9so1256918qvb.0
 for <linux-um@lists.infradead.org>; Tue, 08 Mar 2022 21:35:12 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 0/4] um: Assorted console related fixes
Date: Tue,  8 Mar 2022 23:29:21 -0600
Message-Id: <1f5276f9b2950d34eec89004d2a2322a06145d2b.1646802841.development@efficientek.com>
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Glenn Washburn <development@efficientek.com>

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> When UML terminates (gracefully or panic) it does not always
> cleanup on the host side.
> Especially when fd:0,fd:1 is used as console it can leave a misconfigured
> stdin/out on the host side.
> Also stale processes such as port-helper can left behind.

> This series fixes the console exit code to make sure UML
> undoes everything it changed on the host side.

I gave this a run hoping it would fix the issues I'm seeing with the console
getting messed up when UML exits via halt in the guest. Echo is turned off
and looks like carriage return doesn't work either. I'm using "reset" to get
the terminal back to its previous state. Unfortunately this patch series did
not fix this issue.

I'm not saying that these aren't valid fixes. But it does appear that these
changes don't make sure that "everything" changed on the host side is undone.

Glenn


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

