Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 6 Feb 2020 17:21:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 00/27] docs: virt: manually convert text documents to
 ReST format
Message-ID: <20200206172136.2fd36abd@kernel.org>
In-Reply-To: <20200206171738.75f374da.cohuck@redhat.com>
References: <cover.1581000481.git.mchehab+huawei@kernel.org>
 <20200206171738.75f374da.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Jonathan Corbet <corbet@lwn.net>, linux-um@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Em Thu, 6 Feb 2020 17:17:38 +0100
Cornelia Huck <cohuck@redhat.com> escreveu:

> On Thu,  6 Feb 2020 15:49:57 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Manually convert the documentation under Documentation/virt to ReST,
> > minimizing the usage of uneeded markups and preserving the documentation
> > writer's style.  
> 
> While you're at it: Would it make sense to convert and move the lone
> file under Documentation/virtual/ that survived 2f5947dfcaec
> ("Documentation: move Documentation/virtual to Documentation/virt")
> (probably due to a conflict) under virt/ as well?

Sure. Will do at the next version of this series.

Regards,
Mauro

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

