Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([45.79.88.28])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG5xF-0007ns-AB
 for linux-um@lists.infradead.org; Wed, 09 Sep 2020 19:40:30 +0000
Date: Wed, 9 Sep 2020 13:40:21 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: add a new User Mode Linux HowTo
Message-ID: <20200909134021.290ea546@lwn.net>
In-Reply-To: <14181df1-60a4-530e-e7f2-df4e1a2972a1@cambridgegreys.com>
References: <20200904141115.15708-1-anton.ivanov@cambridgegreys.com>
 <20200909115203.7c898211@lwn.net>
 <14181df1-60a4-530e-e7f2-df4e1a2972a1@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-doc@vger.kernel.org

On Wed, 9 Sep 2020 20:37:35 +0100
Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:

> >> +Create a sparse raw disk image:
> >> +
> >> +.. code-block:: shell
> >> +
> >> +    dd if=/dev/zero of=disk_image_name bs=1 count=1 seek=16G  
> > 
> > I'd honestly do without all these code-block directives as well; they
> > clutter things considerably for little advantage.  
> 
> I can merge most of these into a couple of code snippets. I would like 
> to leave the content though. As UML does not have an official installer, 
> the only way to install it is to build images and there is not that much 
> information on this on the net. The only well written piece on the 
> subject is > 10 years old and becoming a bit out of date.

Don't misunderstand me - the code is fine and welcome.  It's the 
".. code-block::" directives that I'm taking issue with.  I'd rather see
ordinary literal blocks instead.

Thanks,

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

