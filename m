Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com>
 <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
 <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
In-Reply-To: <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Jan 2020 03:43:56 +0000
Message-ID: <CACPK8XddCV6QnvRSS7WcyoN7W3yuUSbyT67on=EMhV7jWDExUg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Eddie James <eajames@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Jeremy Kerr <jk@ozlabs.org>, David Gow <davidgow@google.com>, Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

On Mon, 27 Jan 2020 at 09:46, Brendan Higgins <brendanhiggins@google.com> wrote:

> > > Do you want to get this in a fix for 5.5?
> >
> > Preferably, yes.
> >
> > > Acked-by: Joel Stanley <joel@jms.id.au>
>
> Hey, I know I owe you a reply about debugging your kunitconfig (I'll
> try to get to that this week); nevertheless, it looks like this patch
> didn't make it into 5.5. Can you make sure it gets into 5.6? It
> shouldn't depend on anything else.

Sure, thanks for the reminder.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

