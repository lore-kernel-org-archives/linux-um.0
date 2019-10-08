Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHqoB-0002tm-JP
 for linux-um@lists.infradead.org; Tue, 08 Oct 2019 14:49:53 +0000
Message-ID: <d967492b4d8f815b9cef806691c021a67f295efd.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 08 Oct 2019 16:49:41 +0200
In-Reply-To: <3cb5a05b-1b63-24e0-be1b-383c7b9230e0@cambridgegreys.com>
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <50395b43-5952-0df5-b753-b3de4c246ed4@cambridgegreys.com>
 <8718663842671e3d825ccc8eef6f9669a5a85884.camel@sipsolutions.net>
 <3cb5a05b-1b63-24e0-be1b-383c7b9230e0@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>

On Tue, 2019-10-08 at 15:17 +0100, Anton Ivanov wrote:

> > Or maybe just not allow this to be a module? Then it cannot be loaded
> > from inside, and the command-line must be given from outside, I think?
> > We could change it to use __uml_setup() too.
> 
> That would do it.

I think that's probably easiest then.

> > Perhaps with kexec() it's possible to influence the next kernel's
> > command line though, but that might already be an issue then?
> 
> It is an issue, if kexec works.

I was misremembering the code in main() - it does an exec() of itself
(with unchanged parameters) for a *reboot*. Somehow I associated that
with kexec().

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

