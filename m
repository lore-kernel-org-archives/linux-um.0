Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idO1f-00055U-Po
 for linux-um@lists.infradead.org; Sat, 07 Dec 2019 00:32:48 +0000
Received: by mail-pf1-x441.google.com with SMTP id h14so4180939pfe.10
 for <linux-um@lists.infradead.org>; Fri, 06 Dec 2019 16:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
In-Reply-To: <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 6 Dec 2019 16:32:34 -0800
Message-ID: <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: johannes.berg@intel.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>

On Thu, Dec 5, 2019 at 11:23 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
[...]
> 1. There is a proposed patch for the build system to fix it.
>
> 2. We should be removing all old drivers and replacing them with the
> vector ones.

Hmm...does this mean you would entertain a patch removing all the
non-vector UML network drivers? I would be happy to see VDE go as
well.

In any event, it sounds like I should probably drop this patch as it
is currently.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

